
class Rnk {
  final int id;
  final String title, rankpoints, award;

  Rnk({
    required this.id,
    required this.title,
    required this.rankpoints,
    required this.award,
  });
}

List<Rnk> rnkpoint = [
  Rnk(id: 1, title: "Distributor", rankpoints: "2500", award: "7000"),
  Rnk(id: 2, title: "Silver", rankpoints: "10000", award: "200000"),
  Rnk(id: 3, title: "Gold", rankpoints: "25000", award: "40000"),
  Rnk(id: 4, title: "Platinum", rankpoints: "50000", award: "70000"),
  Rnk(id: 5, title: "Diamond", rankpoints: "100000", award: "Trip + 70000"),
  Rnk(id: 6, title: "Crown", rankpoints: "250000", award: "250000"),
  Rnk(id: 7, title: "Double Crown", rankpoints: "500000", award: "500000"),
  Rnk(id: 8, title: "Star", rankpoints: "1000000", award: "10,00,000"),
  Rnk(id: 9, title: "Double Star", rankpoints: "2500000", award: "25,00,000"),
  Rnk(id: 10, title: "Super Star", rankpoints: "5000000", award: "50,00,000"),
  Rnk(id: 11, title: "Royal", rankpoints: "10000000", award: "1,00,00,000"),
  Rnk(
      id: 12,
      title: "Royal Achiever",
      rankpoints: "40000000",
      award: "4,00,00,000"),
];
