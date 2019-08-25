package ca.recommendmovie.models;

public class User implements Comparable {

    private String user_id;
    private Double cosineSimilarity;

    public User(String user_id, Double cosineSimilarity) {
        this.user_id = user_id;
        this.cosineSimilarity = cosineSimilarity;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public Double getCosineSimilarity() {
        return cosineSimilarity;
    }

    public void setCosineSimilarity(Double cosineSimilarity) {
        this.cosineSimilarity = cosineSimilarity;
    }

    @Override
    public int compareTo(Object o) {
        return this.getCosineSimilarity().compareTo(((User) o).getCosineSimilarity());
    }
}
