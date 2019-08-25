package ca.recommendmovie.controllers;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import ca.recommendmovie.models.Movie;
import ca.recommendmovie.models.Review;
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

    @PostConstruct
    private void init() throws IOException {
        // initialize database

        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(GoogleCredentials.getApplicationDefault())
                .setDatabaseUrl("https://movielemma.firebaseio.com/")
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
                List<Review> userReviewed = (List<Review>) reviews.get(review.getUser_id());
                userReviewed.add(review);
            } else {
                List<Review> userReviewed = new ArrayList<Review>();
                reviews.put(review.getUser_id(), userReviewed);

            }
        }

//        // Hash reviews based on userId
//        for (Review review : reviews) {
//
//        }


//        // find cosine similarities between all users and userId passed in
//        for (String userId : userIds) {
//
//        }

        return "hi";
    }
}
