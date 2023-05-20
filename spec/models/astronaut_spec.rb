require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many(:missions).through(:astronaut_missions) }
  end

  describe "class method" do
    let!(:astronaut_1) {Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")}
    let!(:astronaut_2) {Astronaut.create!(name: "Jeff Smith", age: 56, job: "Pilot")}
    let!(:astronaut_3) {Astronaut.create!(name: "Buzz Lightyear", age:20, job: "Explorer")}

    describe "#average_age" do
      it "returns the average age" do
        expect(Astronaut.average_age).to eq(37.67)
      end
    end
  end

  describe "instance method" do
    before(:each) do
      @mission_1 = Mission.create!(title: "Apollo 13", time_in_space: 34)
      @mission_2 = Mission.create!(title: "Capricorn 4", time_in_space: 58)
      @mission_3 = Mission.create!(title: "Gemini 7", time_in_space: 187)

      @astronaut_1 = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      AstronautMission.create!(astronaut: @astronaut_1, mission: @mission_1)
      AstronautMission.create!(astronaut: @astronaut_1, mission: @mission_2)
      AstronautMission.create!(astronaut: @astronaut_1, mission: @mission_3)

      @astronaut_2 = Astronaut.create!(name: "Jeff Smith", age: 56, job: "Pilot")
      AstronautMission.create!(astronaut: @astronaut_2, mission: @mission_1)
      AstronautMission.create!(astronaut: @astronaut_2, mission: @mission_2)
      
      @astronaut_3 = Astronaut.create!(name: "Buzz Lightyear", age:20, job: "Explorer")
      AstronautMission.create!(astronaut: @astronaut_3, mission: @mission_2)
    end

    context "#total_time_space" do
      it "returns sum of all time in space for each astronaut" do
        expect(@astronaut_1.total_time_space).to eq(279)
        expect(@astronaut_2.total_time_space).to eq(92)
        expect(@astronaut_3.total_time_space).to eq(58)
      end
    end
  end
end
