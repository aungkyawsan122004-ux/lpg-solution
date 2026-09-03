package com.lpg.model;

public class Content {
    private int id;
    private String title;
    private String category;
    private String badgeType;
    private String description;

    public Content() {}

    public Content(String title, String category, String badgeType, String description) {
        this.title = title;
        this.category = category;
        this.badgeType = badgeType;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getBadgeType() { return badgeType; }
    public void setBadgeType(String badgeType) { this.badgeType = badgeType; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}