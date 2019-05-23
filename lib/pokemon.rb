require "pry"
class Pokemon

    attr_accessor :id, :name, :type, :db, :hp

    def initialize(id:, name:, type:, db:, hp: 60)
        @id = id
        @name = name
        @type = type
        @db = db
        @hp = hp
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type) 
        VALUES (?, ?);
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * 
        FROM pokemon
        WHERE id = ?
        LIMIT 1;
        SQL
        pokemon_data = db.execute(sql, id)[0]

        Pokemon.new(id: pokemon_data[0], name: pokemon_data[1], type: pokemon_data[2], hp: pokemon_data[3], db: db)
    end
    #binding.pry
    
    # def check_hp(id, db)
    #     sql = <<-SQL
    #     SELECT * 
    #     FROM pokemon 
    #     WHERE id = ?;
    #     SQL
    #     db.execute(sql, id)
    # end

    def alter_hp(hp, db)
        sql = <<-SQL
        UPDATE pokemon 
        SET hp = ? 
        WHERE id = ?;
        SQL
        db.execute(sql, hp, self.id)
    end

end
