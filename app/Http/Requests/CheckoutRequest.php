<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CheckoutRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $emailValidation = auth()->user() ? 'required|email' : 'required|email|unique:users';
        return [
            'email' => $emailValidation,
            'name' => 'required|max:255|min:3',
            'address1' => 'required',
            'phone' => 'required|digits:10',
        ];
    }

    public function messages() {
        return [
            'address1.required' => "Vui lòng cung cấp địa chỉ nhận hàng!",
            'name.required' => "Vui lòng cung cấp họ tên!",
            'email.required' => "Vui lòng nhập địa chỉ email!",
            'phone.required' => "Vui lòng cung cấp số điện thoại liên lạc!",
            'phone.digits' => "Số điện thoại không đúng!",
        ];
    }
}
