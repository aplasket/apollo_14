require "rails_helper"

RSpec.describe AstronautMission, type: :model do
  describe "Relationship" do
    it { should belong_to :mission }
    it { should belong_to :astronaut }
  end
end