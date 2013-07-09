require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @product_attr = { 
        name: @product.name, 
        sku: @product.sku,
        permalink: @product.permalink,
        description: @product.description,

        retail_price: @product.retail_price,
        sale_price: @product.sale_price,
        commission_amount: @product.commission_amount,

        available_on: @product.available_on,
        deleted_at: @product.deleted_at, }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @product_attr
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: @product_attr
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end

  test "upload" do
    get :upload
    assert_response :success
    assert_blank assigns(:files)
  end

  test "uploading" do
    assert_difference('CsvFile.count') do
      post :uploading, file: fixture_file_upload('files/sample.csv', 'text/csv')
    end
    file = CsvFile.first
    assert_redirected_to results_products_path(fid: file.id)
  end

  test "results" do
    post :uploading, file: fixture_file_upload('files/sample.csv', 'text/csv')
    file = CsvFile.last
    get :results, fid: file.id
    assert assigns(:file) == file
    assert_equal file.dump_products.count, 3
    assert_equal CsvFile.count, 1
  end

  test "importing" do
    post :uploading, file: fixture_file_upload('files/sample.csv', 'text/csv')
    file = CsvFile.last

    assert_difference('Product.count', 3) do
      post :importing, 'pid' => [1,2,3], fid: file.id  
    end

    assert_difference('Product.count', 2) do
      post :importing, 'pid' => [1,3], fid: file.id  
    end

    assert_difference('Product.count', 1) do
      post :importing, 'pid' => [2], fid: file.id  
    end

    assert_difference('Product.count', 0) do
      post :importing, 'pid' => [], fid: file.id 
      assert_redirected_to products_path
    end

  end

  test "multiple_edit" do
    pids = [1,3]
    post :multiple_edit, pid: pids
    assert_equal assigns(:products).count, 2
    assert_equal assigns(:products).map {|pp| pp.id}, pids
  end

  test "multiple_clone" do
    pids = [1,2,3]
    post :multiple_edit, pid: pids
    assert_equal assigns(:products).count, 3
    assert_equal assigns(:products).map {|pp| pp.id}, pids
  end

  test "multiple_update" do
    post :multiple_update, method: :put, 'products' => {'1' => {'name' => 'Product 01 (edit)'}, '2' => {'sku' => 'P02 (edit)'}}
    product_1 = Product.find 1
    assert_equal product_1.name, 'Product 01 (edit)'
    product_2 = Product.find 2
    assert_equal product_2.sku, 'P02 (edit)'
  end

  test "multiple_duplicate" do
    assert_difference('Product.count', 2) do
      post :multiple_duplicate, "products"=>{
        "98"=>{"sku"=>"P503 (copy)", "name"=>"Prod 03 (copy)", "permalink"=>"", "sale_price"=>"9", "commission_amount"=>"2", "retail_price"=>"12", "blocked"=>"0"}, 
        "99"=>{"sku"=>"P60199 (copy)", "name"=>"Prod 02 (copy)", "permalink"=>"haha", "sale_price"=>"89.99", "commission_amount"=>"4.99", "retail_price"=>"99.99", "blocked"=>"0"}}
    end
    assert_not_nil Product.find_by_name('Prod 03 (copy)')
    assert_not_nil Product.find_by_sku('P60199 (copy)')
  end

  # with validates error 

  test "multiple_update with errors" do
    post :multiple_update, method: :put, 'products' => {'1' => {'name' => ''}, '2' => {'sku' => ''}}
    assert_equal assigns(:products).count, 2
    assigns(:products).each do |pp|
      assert pp.errors.any?
    end

    post :multiple_update, method: :put, 'products' => {'1' => {'name' => ''}}
    assigns(:products).each do |pp|
      assert pp.errors.keys.include?(:name)
      assert_equal pp.errors[:name], ["can't be blank"]
    end

    post :multiple_update, method: :put, 'products' => {'2' => {'sku' => ''}}
    assigns(:products).each do |pp|
      assert pp.errors.keys.include?(:sku)
      assert_equal pp.errors[:sku], ["can't be blank"]
    end

    assert_template 'multiple_edit'
  end

  test "multiple_duplicate with errors" do
    post :multiple_duplicate, 'products' => {'1' => {'name' => ''}, '2' => {'sku' => ''}}
    assert_equal assigns(:products).count, 2
    assigns(:products).each do |pp|
      assert pp.errors.any?
    end

    post :multiple_duplicate, 'products' => {'1' => {'name' => ''}}
    assigns(:products).each do |pp|
      assert pp.errors.keys.include?(:name)
      assert_equal pp.errors[:name], ["can't be blank"]
      assert_equal pp.id, 1
    end

    post :multiple_duplicate, 'products' => {'2' => {'sku' => ''}}
    assigns(:products).each do |pp|
      assert pp.errors.keys.include?(:sku)
      assert_equal pp.errors[:sku], ["can't be blank"]
      assert_equal pp.id, 1
    end

    assert_template 'multiple_clone'
  end

end
