class Fixnum
  def round_up
    divisor = 10 ** Math.log10(self).floor
    i = self / divisor
    if self % divisor == 0
      i * divisor
    else
      (i + 1) * divisor
    end
  end
end
