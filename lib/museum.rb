class Museum
    attr_reader :name, :exhibits, :patrons

    def initialize(name)
        @name = name
        @exhibits = []
        @patrons = []
    end

    def admit(patron)
        @patrons << patron
    end

    def add_exhibit(exhibit)
        @exhibits << exhibit
    end

    def recommend_exhibits(patron)
        @exhibits.find_all do |exhibit|
          patron.interests.include?(exhibit.name)
        end
    end

    def patrons_by_exhibit_interest
        patrons_by_exhibit_interest = {}
        @exhibits.each do |exhibit|
            patrons_by_exhibit_interest[exhibit] = interested_patrons(exhibit)
        end
        patrons_by_exhibit_interest
    end

    def interested_patrons(exhibit)
        @patrons.select do |patron|
            patron.interests.include?(exhibit.name)
        end
    end

    def ticket_lottery_contestants(exhibit)
        patrons_in_lottery = []

        @patrons.each do |patron|
            if patron.interests.include?(exhibit.name) && patron.spending_money < exhibit.cost
                patrons_in_lottery << patron
            end
        end
     
        patrons_in_lottery
    end

    def draw_lottery_winner(exhibit)
        contestants = ticket_lottery_contestants(exhibit)
        winner = contestants.sample
        if winner
            winner.name
        else
            nil
        end
    end

    def announce_lottery_winner(exhibit)
        if draw_lottery_winner(exhibit)
            puts "#{draw_lottery_winner(exhibit)} has won the #{exhibit} lottery!"
        else
            puts "No winners for this lottery."
        end
    end

end