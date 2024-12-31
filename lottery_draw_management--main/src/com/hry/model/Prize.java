package com.hry.model;

import javax.swing.*;

public class Prize {
    private int id;
    private String prizeLevel;
    private int prizeQuantity;
    private String prizeName;

    private Integer attend_mode;

    private Integer lotter_mode;

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPrizeLevel() {
        return prizeLevel;
    }

    public void setAttend_mode(Integer v) {this.attend_mode = v;}

    public Integer getAttend_mode() {return this.attend_mode;}

    public void setLotter_mode(Integer v) {this.lotter_mode = v;}

    public Integer getLotter_mode() {return this.lotter_mode;}

    public void setPrizeLevel(String prizeLevel) {
        this.prizeLevel = prizeLevel;
    }


    public int getPrizeQuantity() {
        return prizeQuantity;
    }

    public void setPrizeQuantity(int prizeQuantity) {
        this.prizeQuantity = prizeQuantity;
    }

    public String getPrizeName() {
        return prizeName;
    }

    public void setPrizeName(String prizeName) {
        this.prizeName = prizeName;
    }
}
