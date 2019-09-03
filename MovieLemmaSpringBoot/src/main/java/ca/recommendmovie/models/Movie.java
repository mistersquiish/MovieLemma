package ca.recommendmovie.models;

import java.util.Date;

public class Movie {
    private String title;
    private String id;
    private String poster_path;
    private String release_date;
    private String backdrop_path;
    private Double vote_average;
    private Double vote_count;
    private Double predicted_rating;

    public Movie(String title, String id, String poster_path, String release_date, String backdrop_path, Double vote_average, Double vote_count) {
        this.title = title;
        this.id = id;
        this.poster_path = poster_path;
        this.release_date = release_date;
        this.backdrop_path = backdrop_path;
        this.vote_average = vote_average;
        this.vote_count = vote_count;
    }

    public Movie() {}

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPoster_path() {
        return poster_path;
    }

    public void setPoster_path(String poster_path) {
        this.poster_path = poster_path;
    }

    public String getRelease_date() {
        return release_date;
    }

    public void setRelease_date(String release_date) {
        this.release_date = release_date;
    }

    public String getBackdrop_path() {
        return backdrop_path;
    }

    public void setBackdrop_path(String backdrop_path) {
        this.backdrop_path = backdrop_path;
    }

    public Double getVote_average() {
        return vote_average;
    }

    public void setVote_average(Double vote_average) {
        this.vote_average = vote_average;
    }

    public Double getVote_count() {
        return vote_count;
    }

    public void setVote_count(Double vote_count) {
        this.vote_count = vote_count;
    }

    public Double getPredicted_rating() {
        return predicted_rating;
    }

    public void setPredicted_rating(Double predicted_rating) {
        this.predicted_rating = predicted_rating;
    }
}
