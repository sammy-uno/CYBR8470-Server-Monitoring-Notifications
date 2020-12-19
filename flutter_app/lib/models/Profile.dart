class Profile {
  String userId;
  String email;
  String firstName;
  String lastName;
  String address;
  String city;
  String state;
  String zipCode;
  String fcmToken;

  Profile(this.userId, this.email, this.firstName, this.lastName, this.address,
        this.city, this.state, this.zipCode);


  String fullName() {
    return this.firstName + " " + this.lastName;
  }

}
