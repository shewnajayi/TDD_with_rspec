require 'rails_helper'

describe Contact do
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
       firstname: 'Seun',
       lastname: 'Ajayi',
       email: 'seunfunmilola@gmail.com'
    )
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = Contact.new(firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end
  it "is invalid without a lastname" do
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end
  it "is invalid without an email address" do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end
  it "is invalid with a duplicate email address" do
    contact = Contact.create(
     firstname: 'Seun', lastname: 'Tester',
     email: 'seunfunmilola@gmail.com'
    )
    contact = Contact.new(
     firstname: 'Jane', lastname: 'Tester',
     email: 'seunfunmilola@gmail.com'
    )
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end
  it "returns a contact's full name as a string" do
    contact = Contact.new(
     firstname: 'Jane', lastname: 'Tester',
     email: 'seunfunmilola@gmail.com'
    )
    expect(contact.name).to eq "Jane Tester"
  end

  describe "filter last name by letter" do
   before :each do
    @schmidt = Contact.create(
     firstname: 'Tester', lastname: 'Schmidt',
     email: 'schmidt@gmail.com'
    )
    @jones = Contact.create(
     firstname: 'Tester', lastname: 'Jones',
     email: 'JT@gmail.com'
    )
    @john = Contact.create(
     firstname: 'Tester', lastname: 'John',
     email: 'JohnT@gmail.com'
    )
   end
    context "matching letters" do
     it "returns a sorted array of results that match" do
      expect(Contact.by_letter("J")).to eq [@john,@jones]
     end
    end
    context "non-matching letters" do
     it "omits results that do not match" do
      expect(Contact.by_letter("J")).not_to include @schmidt
    end
    end
  end
end