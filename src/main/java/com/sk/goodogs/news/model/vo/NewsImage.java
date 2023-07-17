package com.sk.goodogs.news.model.vo;

import java.sql.Timestamp;

public class NewsImage {
    private int scriptNo;
    private String originalFilename;
    private String renamedFilename;
    private Timestamp imageRegDate;


    public NewsImage() {
        super();
        // TODO Auto-generated constructor stub
    }


    public NewsImage(int scriptNo, String originalFilename, String renamedFilename, Timestamp imageRegDate) {
        super();
        this.scriptNo = scriptNo;
        this.originalFilename = originalFilename;
        this.renamedFilename = renamedFilename;
        this.imageRegDate = imageRegDate;
    }


    public int getScriptNo() {
        return scriptNo;
    }


    public void setScriptNo(int scriptNo) {
        this.scriptNo = scriptNo;
    }


    public String getOriginalFilename() {
        return originalFilename;
    }


    public void setOriginalFilename(String originalFilename) {
        this.originalFilename = originalFilename;
    }


    public String getRenamedFilename() {
        return renamedFilename;
    }


    public void setRenamedFilename(String renamedFilename) {
        this.renamedFilename = renamedFilename;
    }


    public Timestamp getImageRegDate() {
        return imageRegDate;
    }


    public void setImageRegDate(Timestamp imageRegDate) {
        this.imageRegDate = imageRegDate;
    }


    @Override
    public String toString() {
        return "NewsImage [scriptNo=" + scriptNo + ", originalFilename=" + originalFilename + ", renamedFilename="
                + renamedFilename + ", imageRegDate=" + imageRegDate + "]";
    }



}