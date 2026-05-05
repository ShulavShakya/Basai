package basai.user.model;

import java.time.LocalDateTime;

public class User {

    public enum VerificationStatus{
        Verified, Pending
    }

    private int user_id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String dob;
    private String profilePhoto;
    private String occupation;
    private String preferredLocation;
    private String verificationDocument;
    private VerificationStatus verificationStatus;
    private String role;
    private LocalDateTime created_at;

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }


    public String getProfilePhoto() {
        return profilePhoto;
    }

    public void setProfilePhoto(String profilePhoto) {
        this.profilePhoto = profilePhoto;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getPreferredLocation() {
        return preferredLocation;
    }

    public void setPreferredLocation(String preferredLocation) {
        this.preferredLocation = preferredLocation;
    }

    public String getVerificationDocument() {
        return verificationDocument;
    }

    public void setVerificationDocument(String verificationDocument) {
        this.verificationDocument = verificationDocument;
    }

    public VerificationStatus getVerificationStatus() {
        return verificationStatus;
    }

    public void setVerificationStatus(VerificationStatus verificationStatus) {
        this.verificationStatus = verificationStatus;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public User(int user_id, String name, String email, String password, String phone, String dob, String profilePhoto, String occupation, String preferredLocation, String verificationDocument, VerificationStatus verificationStatus, String role) {
        this.user_id = user_id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.dob = dob;
        this.profilePhoto = profilePhoto;
        this.occupation = occupation;
        this.preferredLocation = preferredLocation;
        this.verificationDocument = verificationDocument;
        this.verificationStatus = verificationStatus;
        this.role = role;
    }

    public User(String name, String email, String password, String phone, String dob, String profilePhoto, String occupation, String preferredLocation, String verificationDocument, VerificationStatus verificationStatus, String role) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.dob = dob;
        this.profilePhoto = profilePhoto;
        this.occupation = occupation;
        this.preferredLocation = preferredLocation;
        this.verificationDocument = verificationDocument;
        this.verificationStatus = verificationStatus;
        this.role = role;
    }

    public User(int user_id, String name, String email, String password, String role) {
        this.user_id = user_id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
    }
}
