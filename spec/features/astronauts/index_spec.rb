require "rails_helper"

RSpec.describe "/astronauts index page" do
  describe "as a visitor to index page" do
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
  
    it "shows a list of astronauts and their attributes" do
      visit "/astronauts"
      # save_and_open_page
      expect(page).to have_content("All Astronauts")
      expect(page).to have_content("Name: #{@astronaut_1.name}")
      expect(page).to have_content("Age: #{@astronaut_1.age}")
      expect(page).to have_content("Job: #{@astronaut_1.job}")

      expect(page).to have_content("Name: #{@astronaut_2.name}")
      expect(page).to have_content("Age: #{@astronaut_2.age}")
      expect(page).to have_content("Job: #{@astronaut_2.job}")
      
      expect(page).to have_content("Name: #{@astronaut_3.name}")
      expect(page).to have_content("Age: #{@astronaut_3.age}")
      expect(page).to have_content("Job: #{@astronaut_3.job}")
    end

    it "shows average age of all astronauts" do
      visit "/astronauts"
      expect(page).to have_content("Average Age: 38")
    end

    it "lists all space missions names in alpha order and time in space for each astronaut" do
      visit "/astronauts"

      within "#astro_id-#{@astronaut_1.id}" do
        expect("Apollo 13").to appear_before("Capricorn 4")
        expect("Capricorn 4").to appear_before("Gemini 7")
        expect(page).to have_content("Total Time in Space: 279")
      end

      within "#astro_id-#{@astronaut_2.id}" do
        expect("Apollo 13").to appear_before("Capricorn 4")
        expect(page).to_not have_content("Gemini 7")
        expect(page).to have_content("Total Time in Space: 92")
      end
      
      within "#astro_id-#{@astronaut_3.id}" do
        expect(page).to have_content("Capricorn 4")
        expect(page).to_not have_content("Apollo 13")
        expect(page).to_not have_content("Gemini 7")
        expect(page).to have_content("Total Time in Space: 58")
      end
    end
  end
end