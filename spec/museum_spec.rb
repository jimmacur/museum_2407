require './lib/museum'
require './lib/exhibit'
require './lib/patron'

RSpec.configure do |config|
    config.formatter = :documentation
end

RSpec.describe Museum do
    before(:each) do
        @dmns = Museum.new("Denver Museum of Nature and Science")
        
        @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
        @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
        @imax = Exhibit.new({name: "IMAX",cost: 15})

        @patron_1 = Patron.new("Bob", 20)
        @patron_1.add_interest("Dead Sea Scrolls")
        @patron_1.add_interest("Gems and Minerals")
        
        @patron_2 = Patron.new("Sally", 20)
        @patron_2.add_interest("IMAX")

        @patron_3 = Patron.new("Johnny", 5)
        @patron_3.add_interest("Dead Sea Scrolls")
    end

    describe 'instantiate' do
        it 'exists' do
            expect(@dmns).to be_an_instance_of Museum
        end

        it 'has a name' do
            expect(@dmns.name).to eq "Denver Museum of Nature and Science"
        end

        it 'has exhibits as an empty array' do
            expect(@dmns.exhibits).to eq []
        end
    end

    describe 'exhibits'do
        it 'can add exhibits' do
            @dmns.add_exhibit(@gems_and_minerals)
            @dmns.add_exhibit(@dead_sea_scrolls)
            @dmns.add_exhibit(@imax)

            expect(@dmns.exhibits).to eq [@gems_and_minerals, @dead_sea_scrolls, @imax]
        end

        it 'can recommend exhibits' do
            @dmns.add_exhibit(@gems_and_minerals)
            @dmns.add_exhibit(@dead_sea_scrolls)
            @dmns.add_exhibit(@imax)

            expect(@dmns.recommend_exhibits(@patron_1)).to eq [@gems_and_minerals, @dead_sea_scrolls]
        end 
    end

    
    describe 'patrons' do
        it 'has patrons as an empty array' do
            expect(@dmns.patrons).to eq []
        end

        it 'can admit patrons' do
            @dmns.admit(@patron_1)
            @dmns.admit(@patron_2)
            @dmns.admit(@patron_3)

            expect(@dmns.patrons).to eq [@patron_1, @patron_2, @patron_3]
        end

        it 'can list patrons by exhibit interest' do
            @dmns.add_exhibit(@gems_and_minerals)
            @dmns.add_exhibit(@dead_sea_scrolls)
            @dmns.add_exhibit(@imax)

            @dmns.admit(@patron_1)
            @dmns.admit(@patron_2)
            @dmns.admit(@patron_3)

            expect(@dmns.patrons_by_exhibit_interest).to be_a Hash
        end

        it 'has an empty array for lottery ticket contestants' do
            expect(@dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq []
        end
    end

end