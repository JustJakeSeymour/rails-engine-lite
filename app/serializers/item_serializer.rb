class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id

  def self.one_book(book)
        {
            "data": {
                        "id": book.id,
                        "type": book.class.to_s.downcase,
                        "attributes": {
                            "title": book.title,
                            "author": book.author
                        }
                    }
         }
    end
end
