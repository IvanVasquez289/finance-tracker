class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def accion_ya_rastreada?(ticker_symbol)
    # esto verifica si la stock existe, no necesariamente si el usuario la tiene, solo checa que exista en la Stock table 
    stock = Stock.revisar_db(ticker_symbol)
    return false unless stock
    # user.stocks.where(id:5) asi lo pongo en consola, pero el user va implicito
    stocks.where(id: stock.id).exists?

  end
  
  def debajo_limite_acciones?
    # user.stocks.count < 10 el user va implicito pq estamos en el modelo user
    stocks.count < 10
  end

  def puede_rastrear_acciones?(ticker_symbol)
    debajo_limite_acciones? && !accion_ya_rastreada?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    'Anonimo'
  end

  def self.search(param)
    # el strip corta los espacios en blanco es como un trim en js
    param.strip!
    reciba_algo = (first_name_coincide(param) + last_name_coincide(param) + email_coincide(param)).uniq
    return nil unless reciba_algo
    reciba_algo
  end

  def self.first_name_coincide(param)
    coincide('first_name', param)
  end

  def self.last_name_coincide(param)
    coincide('last_name', param)
  end
  
  def self.email_coincide(param)
    coincide('email', param)
  end
  

  def self.coincide(tipo_campo, param) 
    # User.where("email like?",  "%example%")
    where("#{tipo_campo} like?",  "%#{param}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }  
  end
  
  def no_es_amigo_de?(friend_id)
    !friends.where(id: friend_id).exists?
  end
  
end
