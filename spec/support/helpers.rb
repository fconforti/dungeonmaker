# frozen_string_literal: true

def stub_dice_roll(string, total)
  result = instance_double(DiceBag::Result)
  dice_roll = instance_double(DiceBag::Roll)
  allow(result).to receive(:total).and_return(total)
  allow(dice_roll).to receive(:result).and_return(result)
  allow(DiceBag::Roll).to receive(:new).with(string).and_return(dice_roll)
end
