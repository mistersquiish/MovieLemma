package ca.recommendmovie.models;

public class Review {
    private Movie movie;
    private String userId;
    private int rating;

    public Review(Movie movie, String userId, int rating) {
        this.movie = movie;
        this.userId = userId;
        this.rating = rating;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }
}
