<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'category_id',
        'name',
        'description',
        'price',
        'image',
        'criteria',
        'favorite',
        'status',
        'stock',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function toArray()
    {
        $array = parent::toArray();
        $array['created_at'] = Carbon::parse($this->created_at)->format('d-m-Y H:i:s');
        $array['updated_at'] = Carbon::parse($this->updated_at)->format('d-m-Y H:i:s');
        return $array;
    }
}
