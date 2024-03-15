# This class Parses a natural language date string and returns a DateTime object
class ChronicService
  def self.parse(date_str, context: :future)
    Chronic.parse(date_str, context: context)
  end
end
