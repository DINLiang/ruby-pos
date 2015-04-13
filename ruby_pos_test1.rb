gem "minitest"
require 'minitest/autorun'
require_relative 'ruby_pos'

class GoodsTest < MiniTest::Test
  def test_get_all_goods
    inputs = [
        'ITEM000001',
        'ITEM000001',
        'ITEM000001',
        'ITEM000001',
        'ITEM000001',
        'ITEM000003-2',
        'ITEM000005',
        'ITEM000005',
        'ITEM000005' ]
    shop_goods = [
        {
            barcode: 'ITEM000000',
            name: '可口可乐',
            unit: '瓶',
            price: 3.00
        },
        {
            barcode: 'ITEM000001',
            name: '雪碧',
            unit: '瓶',
            price: 3.00
        },
        {
            barcode: 'ITEM000002',
            name: '苹果',
            unit: '斤',
            price: 5.50
        },
        {
            barcode: 'ITEM000003',
            name: '荔枝',
            unit: '斤',
            price: 15.00
        },
        {
            barcode: 'ITEM000004',
            name: '电池',
            unit: '个',
            price: 2.00
        },
        {
            barcode: 'ITEM000005',
            name: '方便面',
            unit: '袋',
            price: 4.50
        }
    ]
    all_goods = Goods.new.get_all_goods(inputs,shop_goods)
    result = [{:barcode=>"ITEM000001", :name=>"雪碧", :unit=>"瓶", :price=>3.0, :count=>5},
    {:barcode=>"ITEM000003", :name=>"荔枝", :unit=>"斤", :price=>15.0, :count=>"2"},
    {:barcode=>"ITEM000005", :name=>"方便面", :unit=>"袋", :price=>4.5, :count=>3}]
    assert_equal(result,all_goods)
  end
  def test_get_free_list
  promotion_barcode = [
      'ITEM000000',
      'ITEM000001',
      'ITEM000005'
  ]
  all_goods = [{:barcode=>"ITEM000001", :name=>"雪碧", :unit=>"瓶", :price=>3.0, :count=>5},
               {:barcode=>"ITEM000003", :name=>"荔枝", :unit=>"斤", :price=>15.0, :count=>"2"},
               {:barcode=>"ITEM000005", :name=>"方便面", :unit=>"袋", :price=>4.5, :count=>3}]
    free_list = Goods.new.get_free_list(all_goods,promotion_barcode)
    result =
        [{:barcode=>"ITEM000005", :name=>"雪碧", :unit=>"瓶", :price=>3.0, :count=>5, :free_count=>1},
         {:barcode=>"ITEM000005", :name=>"方便面", :unit=>"袋", :price=>4.5, :count=>3, :free_count=>1}]
    assert_equal(result,free_list)
  end
  def test_print_goods_list
    all_goods = [{:barcode=>"ITEM000001", :name=>"雪碧", :unit=>"瓶", :price=>3.0, :count=>5, :free_count=>1},
                             {:barcode=>"ITEM000003", :name=>"荔枝", :unit=>"斤", :price=>15.0, :count=>"2", :free_count=>0},
                             {:barcode=>"ITEM000005", :name=>"方便面", :unit=>"袋", :price=>4.5, :count=>3, :free_count=>1}]
    free_list = [{:barcode=>"ITEM000005", :name=>"雪碧", :unit=>"瓶", :price=>3.0, :count=>5, :free_count=>1},
                 {:barcode=>"ITEM000005", :name=>"方便面", :unit=>"袋", :price=>4.5, :count=>3, :free_count=>1}]
    print_goods_list = Goods.new.print_goods_list(all_goods,free_list)
    result =  "***<没钱赚商店>购物清单***\n" \
            	"名称:雪碧,数量:5瓶,单价:3.00(元),小计:12.00(元)\n" \
              "名称:荔枝,数量:2斤,单价:15.00(元),小计:30.00(元)\n" \
              "名称:方便面,数量:3袋,单价:4.50(元),小计:9.00(元)\n" \
              "----------------------\n" \
              "挥泪赠送商品:\n" \
              "名称:雪碧,数量:1瓶\n" \
              "名称:方便面,数量:1袋\n" \
              "----------------------\n" \
              "总计:51.00(元)\n" \
              "节省:7.50(元)\n" \
              "**********************"
    assert_equal(result,print_goods_list)
  end
end
