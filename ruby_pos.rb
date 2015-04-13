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
promotion_barcode = [
    'ITEM000000',
    'ITEM000001',
    'ITEM000005'
]
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
class Goods
def get_all_goods(inputs,shop_goods)
  all_goods = []
  inputs.uniq.each do |i|
    i, count = i.split('-')
    goods = shop_goods.find{|j| j[:barcode] == i}
    goods.merge!(count: count || inputs.count(i))
    all_goods << goods
  end
  all_goods
end
def get_free_list(all_goods,promotion_barcode)
free_list = []
all_goods.each do |n|
  n[:free_count] = 0
  promotion_barcode.each do |m|
   if n[:barcode] = m
      n[:free_count] = (n[:count].to_i/3).to_i
      if n[:free_count] != 0
      free_list << n
        end
   end
  end
end
free_list.uniq!
end
# free_list = get_free_list(all_goods,promotion_barcode)
# puts free_list
def print_goods_list(all_goods,free_list)
$list = "***<没钱赚商店>购物清单***"
total = 0
save_total = 0
all_goods.each do |k|
  subtotal = k[:price] * k[:count].to_i
  free_subtotal = k[:price] * (k[:count].to_i - k[:free_count].to_i)
  total += free_subtotal
  save_total += subtotal - free_subtotal
  $list = $list + "\n名称:#{k[:name].to_s},数量:#{k[:count].to_s}#{k[:unit].to_s},单价:#{"%.2f" %k[:price].to_s}(元),小计:#{"%.2f" %free_subtotal.to_s}(元)"
end
$list = $list + "\n----------------------\n挥泪赠送商品:"
free_list.each do |f|
  $list = $list + "\n名称:#{f[:name].to_s},数量:#{f[:free_count].to_s}#{f[:unit].to_s}"
end
$list = $list + "\n----------------------\n总计:#{"%.2f" % total}(元)\n节省:#{"%.2f" %save_total}(元)\n**********************"
end
end
all_goods = Goods.new.get_all_goods(inputs,shop_goods)
free_list = Goods.new.get_free_list(all_goods,promotion_barcode)
goods_list = Goods.new.print_goods_list(all_goods,free_list)
puts goods_list
