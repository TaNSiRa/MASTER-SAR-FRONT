String buildControlRange(String min, String symbol, String max) {
  // ตัด space ส่วนเกินออกก่อน
  min = min.trim();
  max = max.trim();
  symbol = symbol.trim();

  // ถ้าทุกค่าคือ "-"
  if (min == "-" && max == "-" && symbol == "-") {
    return "-";
  }

  // ถ้า min และ max ว่างหรือเป็น "-" ทั้งคู่ return ว่าง
  if ((min.isEmpty || min == "-") && (max.isEmpty || max == "-")) {
    return '';
  }

  // กรณี min = "-" หรือว่าง → แสดง symbol + max
  if (min.isEmpty || min == "-") {
    return "$symbol $max".trim();
  }

  // กรณี max = "-" หรือว่าง → แสดง min + symbol
  if (max.isEmpty || max == "-") {
    return "$min $symbol".trim();
  }

  // ถ้ามีครบทั้ง 3 ตัว
  return "$min $symbol $max".trim();
}
