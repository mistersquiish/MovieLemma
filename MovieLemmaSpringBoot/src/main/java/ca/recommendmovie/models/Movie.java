package ca.recommendmovie.models;

public class Movie {
    private String title;
    private int movieId;
    private String posterUrl;
    private int releaseDate;

    public Movie(String title, int movieId, String posterUrl, int releaseDate) {
        this.title = title;
        this.movieId = movieId;
        this.posterUrl = posterUrl;
        this.releaseDate = releaseDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public int getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(int releaseDate) {
        this.releaseDate = releaseDate;
    }
}
