package ca.recommendmovie.controllers;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ExecutionException;

import ca.recommendmovie.models.Movie;
import ca.recommendmovie.models.Review;
import ca.recommendmovie.models.User;
import com.google.api.core.ApiFuture;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.ExportedUserRecord;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.ListUsersPage;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;

@RestController
public class RecommendMovieController {

    Firestore db;
    String db_url = "https://movielemma.firebaseio.com/";

    @PostConstruct
    private void init() throws IOException {
        // initialize database

        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(GoogleCredentials.getApplicationDefault())
                .setDatabaseUrl(db_url)
                .build();

        FirebaseApp.initializeApp(options);
        db = FirestoreClient.getFirestore();
    }

    @GetMapping("/hello")
    public String getHello() {

        return "hello";
    }

    @PostMapping("/recommendation")
    public String recommendMovies(@RequestBody String currentUserId) throws FirebaseAuthException, ExecutionException, InterruptedException {
        List<Movie> recommendedMovies = new ArrayList<Movie>();
        List<String> userIds = new ArrayList<String>();
        Map reviews = new HashMap();

        // Get all users in a list
        ListUsersPage page = FirebaseAuth.getInstance().listUsers(null);
        while (page != null) {
            for (ExportedUserRecord user : page.getValues()) {
                if (!user.getUid().equals(currentUserId)) {
                    userIds.add(user.getUid());
                }
            }
            page = page.getNextPage();
        }

        // Get all reviews in a hashmap
        ApiFuture<QuerySnapshot> future = db.collection("reviews").get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();
        for (DocumentSnapshot document : documents) {
            Review review = document.toObject(Review.class);
            if (reviews.containsKey(review.getUser_id())) {
                Map userReviewed = (Map) reviews.get(review.getUser_id());
                userReviewed.put(review.getMovie().getId(), review);
            } else {
                Map userReviewed = new HashMap();
                userReviewed.put(review.getMovie().getId(), review);
                reviews.put(review.getUser_id(), userReviewed);

            }
        }

        // find cosine similarities between all users and userId passed in and store
        List<User> users = new ArrayList<User>();

        // iterate through current user reviews to get the denominator squared component
        Map<String, Review> currentUserReviews = (Map) reviews.get(currentUserId);
        Double denominatorSquaredComponentA = 0.0;
        for (Map.Entry<String, Review> entry : currentUserReviews.entrySet()) {
            denominatorSquaredComponentA += Math.pow(entry.getValue().getRating(), 2);
        }
        denominatorSquaredComponentA = Math.sqrt(denominatorSquaredComponentA);

        // iterate through all users with reviews and add cosine similarities to list
        for (String userId : userIds) {
            // iterate through all the users except current
            if (userId != currentUserId && reviews.containsKey(userId)) {
                Map<String, Review> userReviews = (Map) reviews.get(userId);
                Double denominatorSquaredComponentB = 0.0;
                Double numerator = 0.0;

                for (Map.Entry<String, Review> entry : userReviews.entrySet()) {
                    denominatorSquaredComponentB += Math.pow(entry.getValue().getRating(), 2);

                    if (currentUserReviews.containsKey(entry.getKey())) {
                        numerator += currentUserReviews.get(entry.getValue().getMovie().getId()).getRating() * entry.getValue().getRating();
                    }
                }
                denominatorSquaredComponentB = Math.sqrt(denominatorSquaredComponentB);

                // add user to users list for comparison later
                User user = new User(userId, numerator / (denominatorSquaredComponentA * denominatorSquaredComponentB));
                users.add(user);
            }
        }
        // sort users list by cosine similarity
        Collections.sort(users, Collections.reverseOrder());

        // only take the top 3 users. if less than 3 total users, take all users
        if (users.size() > 3) {
            users = users.subList(0, 3);
        }


        return "hi";
    }
}
