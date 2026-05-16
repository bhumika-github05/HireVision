package com.hirevision.model;

public class Application {

    private int id;

    private int userId;

    private int jobId;

    private String resumeLink;

    private String status;

    public Application() {
    }

    public Application(int userId,
                       int jobId,
                       String resumeLink) {

        this.userId = userId;
        this.jobId = jobId;
        this.resumeLink = resumeLink;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public String getResumeLink() {
        return resumeLink;
    }

    public void setResumeLink(String resumeLink) {
        this.resumeLink = resumeLink;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}