<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title>Document</title>
  
  <style>
  body{
    padding: 5em 5em 5em 5em;
  }
.page-break {
    page-break-after: always;
}
  /*
	 CSS-Tricks Example
	 by Chris Coyier
	 http://css-tricks.com
*/

* { margin: 0; padding: 0; }
body { font: Roboto, serif; }
#page-wrap { width: 800px; margin: 0 auto; }

textarea { border: 0; font: 14px Roboto, Serif; overflow: hidden; resize: none; }
table { border-collapse: collapse; }
table td, table th { border: 1px solid black; padding: 5px; }

#header { height: 15px; width: 100%; margin: 20px 0; background: #222; text-align: center; color: white; font: bold 15px Helvetica, Sans-Serif; text-decoration: uppercase; letter-spacing: 5px; padding: 8px 0px; }

#address { width: 250px; height: 100px; float: left; }
#customer { overflow: hidden; }

#logo { text-align: right; float: right; position: relative; margin-top: 25px; border: 1px solid #fff; max-width: 540px; max-height: 100px; overflow: hidden; }
#logoctr { display: none; }
#logohelp { text-align: left; display: none; font-style: italic; padding: 10px 5px;}
#logohelp input { margin-bottom: 5px; }
.edit #logohelp { display: block; }
.edit #save-logo, .edit #cancel-logo { display: inline; }
.edit #image, #save-logo, #cancel-logo, .edit #change-logo, .edit #delete-logo { display: none; }
#customer-title { font-size: 20px; font-weight: bold; float: left; }

#meta { margin-top: 1px; width: 300px; float: right; }
#meta td { text-align: right;  }
#meta td.meta-head { text-align: left; background: #eee; }
#meta td textarea { width: 100%; height: 20px; text-align: right; }

#items { clear: both; width: 100%; margin: 30px 0 0 0; border: 1px solid black; }
#items th { background: #eee; }
#items textarea { width: 80px; height: 50px; }
#items tr.item-row td { border: 0; vertical-align: top; }
#items td.description { width: 300px; }
#items td.item-name { width: 210px; }
#items td.description textarea, #items td.item-name textarea { width: 100%; }
#items td.total-line { border-right: 0; text-align: right; }
#items td.total-value { border-left: 0; padding: 10px; }
#items td.total-value textarea { height: 20px; background: none; }
#items td.balance { background: #eee; }
#items td.blank { border: 0; }

#terms { text-align: center; margin: 20px 0 0 0; }
#terms h5 { text-transform: uppercase; font: 13px Helvetica, Sans-Serif; letter-spacing: 10px; border-bottom: 1px solid black; padding: 0 0 8px 0; margin: 0 0 8px 0; }
#terms textarea { width: 100%; text-align: center;}

textarea:hover, textarea:focus, #items td.total-value textarea:hover, #items td.total-value textarea:focus, .delete:hover { background-color:#EEFF88; }

.delete-wpr { position: relative; }
.delete { display: block; color: #000; text-decoration: none; position: absolute; background: #EEEEEE; font-weight: bold; padding: 0px 3px; border: 1px solid; top: -6px; left: -22px; font-family: Verdana; font-size: 12px; }
#hiderow,
.delete {
  display: none;
}
</style>
</head>

<body>
  <div class="page-content browse container">
    @include('voyager::alerts')
    <div class="row">
      <div class="col-md-12">
        <div class="panel panel-bordered">
          <div id="page-wrap">

            <h3 id="header">Hóa đơn</h3>

            <div id="identity">

              <p id="address">{{$bill->address1}} <br> Phone: {{$bill->phone}}</p>

              <div id="logo">
                <img id="image" style="height:5em;width:auto;" src="{{Voyager::image(Voyager::setting('admin.icon_image', ''))}}" alt="logo" />
              </div>
              <br>

            </div>

            <div style="clear:both"></div>

            <div id="customer">

              

              <table id="meta">
                <tr>
                  <td class="meta-head">Mã đơn #</td>
                  <td>{{$bill->id}}</td>
                </tr>
                <tr>

                  <td class="meta-head">Ngày xuất</td>
                  <td>{{now()}}</td>
                </tr>
                <tr>
                  <td class="meta-head">Tổng hóa đơn</td>
                  <td>
                    <div class="due">{{$bill->total}} vnđ</div>
                  </td>
                </tr>

              </table>

            </div>

            <table id="items">

              <tr>
                <th>Tên sản phẩm</th>
                <th>Màu</th>
                <th>Kích thước</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Tổng</th>
              </tr>
              <?php
                  $bill_details = App\Models\BillDetail::where('order_id','=',$bill->id)->get();
              ?>
              @foreach($bill_details as $detail)
              <tr class="item-row">
                <td class="item-name">
                  <div class="delete-wpr"><textarea readonly>{{$detail->product_name}}</textarea></div>
                </td>
                <td class="text-right" style="background-color: {{$detail->color ?? ''}}"></td>
                <td class="">
                  <textarea>{{\App\Models\Product::find($detail->product_id)->attributes()->find($detail->product_attribute_id)->attributesValues()->where('attribute_value_id','=',$detail->attribute_value_id)->first()->name}}</textarea>
                </td>
                <td><textarea readonly class="qty text-right">{{$detail->quantity}}</textarea></td>
                <td><textarea readonly class="cost text-right">{{format($detail->product_price)}}vnd</textarea></td>
                <td><span class="price text-right">{{format($detail->product_price)}}vnd</span></td>
              </tr>
              @endforeach
              <tr>
                <td colspan="4" class="blank"> </td>
                <td colspan="1" class="total-line">Thuế</td>
                <td class="total-value">
                  <div id="subtotal">{{$bill->tax}}</div>
                </td>
              </tr>
              <tr>

                <td colspan="4" class="blank"> </td>
                <td colspan="1" class="total-line">Tổng</td>
                <td class="total-value">
                  <div id="total">{{$bill->total}}</div>
                </td>
              </tr>

            </table>
            <hr>

          </div>
        </div>
      </div>
    </div>
  </div>



</body>

</html>