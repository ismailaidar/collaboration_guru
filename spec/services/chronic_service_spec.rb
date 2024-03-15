require 'rails_helper'

RSpec.describe ChronicService do
  describe '.parse' do
    context 'when given valid natural language dates' do
      it 'parses "next Monday" into a Monday date' do
        travel_to Time.zone.local(2023, 3, 15) do # Example date
          next_monday = ChronicService.parse('next Monday')
          expect(next_monday.wday).to eq(1) # Monday is wday 1
        end
      end

      it 'parses "last Monday" into a Monday date using context' do
        travel_to Time.zone.local(2023, 3, 15) do # Example date
          last_monday = ChronicService.parse('last Monday', context: :past)
          expect(last_monday.wday).to eq(1) # Monday is wday 1
        end
      end
    end

    context 'when given ambiguous or invalid dates' do
      it 'returns nil for unparseable dates' do
        expect(ChronicService.parse('flurble')).to be_nil
      end
    end
  end
end
