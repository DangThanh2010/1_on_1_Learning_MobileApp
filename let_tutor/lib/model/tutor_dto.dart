class TutorDTO {
  TutorDTO(this.id, this.avatar, this.name, this.nation, this.isFavourite, this.introduction,
            this.education, this.experience, this.interests, this.profession);

  final int id;
  final String avatar;
  final String name;
  final String nation;
  final bool isFavourite;
  final String introduction;
  final String education;
  final String experience;
  final String interests;
  final String profession;
}