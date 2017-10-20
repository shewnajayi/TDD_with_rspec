require 'rails_helper'

describe Contact do
  it "is valid with a firstname, lastname and email" do
    contact = build(:contact)
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end
  it "is invalid without a lastname" do
    contact = build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end
  it "is invalid without an email address" do
    contact = build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end
  it "is invalid with a duplicate email address" do
    Contact.destroy_all
    create(:contact, email: "shey@gmail.com")
    contact = build(:contact, email: 'shey@gmail.com')
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end
  it "returns a contact's full name as a string" do
    contact = build(:contact,
     firstname: 'Jane', lastname: 'Tester'
    )
    expect(contact.name).to eq "Jane Tester"
  end
  it "has a valid factory" do
   expect(build(:contact)).to be_valid
  end
  it "has three phone numbers" do
   expect(create(:contact).phones.count).to eq 3
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
    # context "matching letters" do
    #  it "returns a sorted array of results that match" do
    #   expect(Contact.by_letter("J")).to eq [@john,@jones]
    #  end
    # end
    context "non-matching letters" do
     it "omits results that do not match" do
      expect(Contact.by_letter("J")).not_to include @schmidt
    end
    end
  end
end