



List<T3> conbineList<T1, T2, T3>(List<T1> l1, List<T2> l2, T3 Function(T1, T2) zipper) {
  if (l1.isEmpty) throw ArgumentError.value(l1, "l1", "input list cannot be empty");
  if (l1.length != l2.length) throw ArgumentError("Two lists must have the same length");
  List<T3> result = [];
  for(var i = 0; i < l1.length; i++) {
    result.add(zipper(l1[i], l2[i]));
  }
  return result;
}
