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

end
