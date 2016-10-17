require 'spec_helper'
require 'pry-byebug'
require 'pp'

describe Computrabajo do
  it 'is a sanity test' do
  end

  it 'can create, get and destroy publication' do
    publication = ComputrabajoFixture.publication
    result = Computrabajo.create_aviso(publication.body)
    pp result
    publication_id = result["OfferId"]
    expect(publication_id).to be > 0

    publication = Computrabajo.get_aviso(publication_id)
    pp publication
    expect(publication["Status"]).to be > 0

    publication[:offerId] = publication_id
    deleted_publication = Computrabajo.destroy_aviso(publication)
    pp deleted_publication
    expect(deleted_publication.parsed_response).to eq("Offer deleted")
  end

end