class Player {
  final int id;
  final String firstName;
  final String lastName;
  final int number;
  final String avatarURL;
  final int shots;
  final int wristReps;
  final int rebounders;

  Player(this.id, this.firstName, this.lastName, this.number, this.avatarURL,
      this.shots, this.wristReps, this.rebounders);

  @override
  String toString() {
    return 'Player{id: $id, number: $number, shots: $shots, wristReps: $wristReps, rebounders: $rebounders}';
  }
}
