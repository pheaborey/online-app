@extends('voyager::master')
@section('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
@stop
@section('page_header')
    
    <h1 class="page-title">
        <i class="voyager-list"></i>
       Sales Report
    </h1>
    <select id="select_date" class="selectpicker">
        <option value="today">Today</option>
        <option value="yesterday">Yesterday</option>
        <option value="last_seven_day">Last 7days</option>
        <option value="this_month">This Month</option>
        <option value="last_month">Last Month</option>
        <option value="this_year">This Year</option>
        <option value="last_year">Last Year</option>
        <option value="custom">Custom</option>
    </select>
    <span id="span_date" style="display: none">
        <input type="date" id="start_date" value="<?php echo date('Y-m-d');?>">
        <input type="date" id="end_date" value="<?php echo date('Y-m-d');?>">
    </span>
    <button id="btn_export" class="btn btn-success">Export to Excel</button>
    <button id="btn_export_pdf" class="btn btn-success">Export to PDF</button>
    @include('voyager::multilingual.language-selector')
@stop
@section('content')
    <div class="page-content edit-add container-fluid">
        <div class="row">
            <div class="col-md-12">

                <div class="panel panel-bordered">
                    <div class="panel-body">
                        <table id="dataTable" class="table">
                            <thead>
                                <tr>
                                    <th>Sale_No.</th>
                                    <th>Sale_Date</th>
                                    <th>Address</th>
                                    <th>Total_QTY</th>
                                    <th>Cost_Amount</th>
                                    <th>Sale_Amount</th>
                                    <th>Net_Amount</th>
                                    <th>Profit/Lost</th>
                                </tr>
                            </thead>
                            <tbody id="sale_data">

                            </tbody>
                        {{-- </table> --}}
                    </div><!-- panel-body -->

                    <div class="panel-footer">
                        
                            <thead>
                                <tr>
                                    <th colspan="2">Total QTY :<span id="sum_qty"></span></th>
                                    <th>Cost :<span id="sum_cost"></span></th>
                                    <th colspan="2">Sale :<span id="sum_sale"></span></th>
                                    <th colspan="2">Net Amount :<span id="sum_net"></span></th>
                                    <th>Ad Expense :<span id="sum_ad"></span></th>
                                    <th>Total Profit :<span id="sum_profit"></span></th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
@stop
@section('javascript')
    <script>
    $(document).ready(function() {
        
        // Create our number formatter.
        var formatter = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD',
        });

        var today = new Date();
        var current_date = today.toISOString().split('T')[0];
        var start_date = current_date;
        var end_date = current_date;
        var day = today.getDate();
        var month = today.getMonth()+1;
        var year = today.getFullYear();
        $('#select_date').on('change',function(){
            var condition = $('#select_date').val();
            if(condition == 'custom'){
                document.getElementById('span_date').style.display = "inline";
                start_date = current_date;
                end_date = current_date;
            }else{
                document.getElementById('span_date').style.display = "none";
                if(condition == 'this_year'){
                    start_date = year+"-01-01";
                    end_date = year+"-12-31";
                }else if(condition == 'last_year'){
                    start_date = (year-1)+"-01-01";
                    end_date = (year-1)+"-12-31";
                }else if(condition == 'this_month'){
                    start_date = year+"-"+new Date(year, month, 1).toISOString().split('-')[1]+'-01';
                    end_date = new Date(year,month,1).toISOString().split('T')[0];
                }else if(condition == 'last_month'){
                    var lastDate = new Date(year,month-1,1).toISOString().split('T')[0];
                    start_date = lastDate.split('-')[0]+'-'+lastDate.split('-')[1]+'-01';
                    end_date = lastDate;
                }else if(condition == 'last_seven_day'){
                    start_date = new Date(year, month-1, day-7).toISOString().split('T')[0];
                    end_date = new Date(year, month-1, day).toISOString().split('T')[0];
                }else if(condition == 'yesterday'){
                    start_date = new Date(year, month-1, day).toISOString().split('T')[0];
                    end_date = new Date(year, month-1, day).toISOString().split('T')[0];
                }else if(condition == 'today'){
                    start_date = current_date;
                    end_date = current_date;
                }
            }
            $('#end_date').val(end_date)
            $('#start_date').val(start_date).trigger('change');
            $('#end_date').val(end_date).trigger('change');
        })
        $('#start_date, #end_date').on('change',function(){
            var date1 = $('#start_date').val();
            var date2 = $('#end_date').val();
            if(date1 > date2){
                toastr.error("Please select start date equal or less than end date!","Error Date");
            }else{
                var url = '{{ url('get_sale_report') }}';
                $.ajax({
                url:url,
                method:'POST',
                data:{
                        start_date:date1,
                        end_date:date2
                    },
                success:function(response){
                    //console.log(response.ad_expense);
                    if(response.sales.length>0){
                        var tr ='';
                        var sum_qty = 0,sum_cost=0,sum_sale=0,sum_net=0,sum_ad=0,sum_profit=0;
                        response.sales.forEach(sale_data => {
                            tr += (sale_data['status']>0 ? "<tr>" : "<tr style='color:red'>")+
                                    "<td>"+sale_data['id'] +"</td>"+
                                    "<td>"+sale_data['sale_date']+"</td>"+
                                    "<td>"+sale_data['customer_address']+"</td>"+
                                    "<td>"+sale_data['total_qty']+"</td>"+
                                    "<td>"+formatter.format(sale_data['total_cost'])+"</td>"+
                                    "<td>"+formatter.format(sale_data['total_amount'])+"</td>"+
                                    (sale_data['status']<0 ? "<td style='color:red'>"+formatter.format(sale_data['net_amount'])+"</td>" : "<td>"+formatter.format(sale_data['net_amount'])+"</td>")+
                                    (sale_data['profit']<0 ? "<td style='color:red'>" +formatter.format(sale_data['profit']) + "</td>" : "<td>"+formatter.format(sale_data['profit'])+"</td>")+
                                    "<td data-tableexport-display='none'><a href='../admin/sales/"+sale_data['id']+"' target='_blank' class='btn-xs btn-info'> <span class='voyager-eye'></span> View</a></td>"+
                                    "</tr>";
                            sum_qty += (sale_data['status']>0 ? (sale_data['total_qty']-0) : 0);
                            sum_cost += (sale_data['status']>0 ? (sale_data['total_cost']-0) : 0);
                            sum_sale += (sale_data['status']>0 ? (sale_data['total_amount']-0) : 0);
                            sum_net += (sale_data['status']>0 ? (sale_data['net_amount']-0) : 0);
                            sum_profit += (sale_data['status']>0 ? (sale_data['profit']-0) : 0);
                        });
                        sum_ad = response.ad_expense;
                        $('#sale_data').empty().append(tr);
                        $('#sum_qty').text(sum_qty);
                        $('#sum_cost').text(formatter.format(sum_cost));
                        $('#sum_sale').text(formatter.format(sum_sale));
                        $('#sum_net').text(formatter.format(sum_net));
                        $('#sum_ad').text(formatter.format(sum_ad));
                        $('#sum_profit').text(formatter.format(sum_profit - sum_ad));
                    }else{
                        $('#sale_data').empty().append('<tr><td colspan="7"><center style="color:red">No Data</center></td></tr>');
                        $('#sum_qty').text(0);
                        $('#sum_cost').text(formatter.format(0));
                        $('#sum_sale').text(formatter.format(0));
                        $('#sum_net').text(formatter.format(0));
                        $('#sum_ad').text(formatter.format(0));
                        $('#sum_profit').text(formatter.format(0));
                    }
                },
                error:function(error){
                    console.log(error)
                }
                });

            }
        })
        var file_name = 'sale_report-'+ new Date().toISOString();
        $('#btn_export').on('click',function(){
            $('#dataTable').tableExport({fileName: file_name,type:'excel',
                        mso:{
                                fileFormat:'xlsx',
                                worksheetName: ['Table 1','Table 2', 'Table 3']
                            }
                        });
        })
        $('#btn_export_pdf').on('click',function(){
            $('#dataTable').tableExport({fileName: file_name,type:'pdf',
                           pdfmake:{enabled:true,
                                    docDefinition:{pageOrientation:'landscape'}
                                }
                          });
        })
        $('#end_date').val(current_date).trigger('change');
    } );
    </script>
@stop