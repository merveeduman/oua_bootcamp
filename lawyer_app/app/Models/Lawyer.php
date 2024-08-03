<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lawyer extends Model
{
    use HasFactory;

    protected $fillable = [
        'law_id',
        'category',
        'patients',
        'experience',
        'bio_data',
        'status',
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }
}
