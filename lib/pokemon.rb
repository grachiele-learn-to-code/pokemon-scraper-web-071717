class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:nil, name:, type:, db:, hp:nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end


  # CLASS METHOD
  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon (name, type)
    VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
    result = db.execute("SELECT last_insert_rowid() from pokemon")
    @id = db.execute("SELECT last_insert_rowid() from pokemon")[0][0]
  end

  def self.find(id, db)

    sql = <<-SQL
    SELECT * FROM pokemon
    WHERE pokemon.id = ?
    SQL

    result = db.execute(sql, id)[0]

    pokemon = Pokemon.new(id: result[0], name: result[1], type:result[2], db:db, hp:result[3])

  end

  def alter_hp(new_hp, db)
    sql = <<-SQL
    UPDATE pokemon
    SET hp = ?
    WHERE id = ?
    SQL

    result = db.execute(sql, new_hp, self.id)[0]
  end


end
