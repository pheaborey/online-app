<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\SoftDeletes;


class Product extends Model
{
    public function scopeActive($query)
    {
        $id = DB::table('product_stocks')->select('product_id');
        // $id = [1,2,3];
        return $query->whereNotIn('id',$id);
    }
    use SoftDeletes;
    protected $dates = ['deleted_at'];
}
