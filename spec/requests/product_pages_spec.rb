require 'spec_helper'

describe "Product pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    let(:product) { FactoryGirl.create(:product) }

    before(:all) { 40.times { FactoryGirl.create(:product) } }
    after(:all) { Product.delete_all }

    before(:each) do
      sign_in user
      visit products_path
    end

    it { should have_selector('title', text: 'All products') }
    it { should have_selector('h1',    text: 'All products') }

    describe "pagination" do
      it { should have_selector('div.pagination') }

      it "should list each product" do
        Product.paginate(page: 1).each do |product|
          page.should have_selector('li', text: product.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit products_path
        end

        it { should have_link('delete', href: product_path(Product.first)) }
        it "should be able to delete a product" do
          expect { click_link('delete').to change(Product, :count).by(-1) }
        end
      end
    end
  end

  describe "new product" do
    before { visit new_product_path }

    let(:submit) { "Add this product" }

    describe "with invalid information" do
      it "should not create a product" do
        expect { click_button submit }.not_to change(Product, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Create new product') }
        it { should have_content('error') }
        it { should have_error_message('The form contains') }
      end
    end

    describe "with valid information" do
      before { fill_in_valid_product() }

      it "should create a product" do
        expect { click_button submit }.to change(Product, :count).by(1)
      end

      describe "after saving the product" do
        before { click_button submit }
        let(:product) { Product.find_by_name('Samsung Galaxy Nexus') }

        it { should have_selector('title', text: product.name) }
        it { should have_success_message('Product successfully added') }
      end
    end
  end

  describe "edit" do
    let(:product) { FactoryGirl.create(:product) }
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit edit_product_path(product)
    end

    describe "page" do
      it { should have_selector('title',text: "Edit product") }
    end

    # describe "with invalid information" do
      # before { click_button "Save changes" }
# 
      # it { should have_content('error') }
    # end

    # describe "with valid information" do
      # let(:new_name) { "New Name" }
      # let(:new_email) { "new@example.com" }
      # before { perform_valid_edit(new_name, new_email, product) }
# 
      # it { should have_selector('title', text: new_name) }
      # it { should have_success_message('Profile updated') }
      # it { should have_link('Sign out', href: signout_path) }
      # specify { product.reload.name.should == new_name }
      # specify { product.reload.email.should == new_email }
    # end
  end

end
