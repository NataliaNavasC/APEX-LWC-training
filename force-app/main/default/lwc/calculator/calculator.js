import { LightningElement } from 'lwc';
import calculate from '@salesforce/apex/CalculatorController.calculate';

export default class Calculator extends LightningElement {
    result = '';
    factors = ['1','2','3','4','5','6','7','8','9','0'];
    operators = ['+','-','*','/','C','='];

    handleButtonClick(event){
        const value = event.target.value;
        if(value === 'C'){
            this.result = '';
        } else if(value === '='){
            this.calculateResult();
        }
        else{
            this.result += value;
        }
    }
    
    async calculateResult(){
        try{
            this.result = await calculate({ expression: this.result });

        }catch (error) {
            this.result = 'Error';
            console.log('An error has ocurred');
        }

    }

    get result(){
        return this.result;
    }
    get factors(){
        return this.factors;
    }
    get operators(){
        return this.operators;
    }



}