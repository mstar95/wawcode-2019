#include <iostream>

using namespace std;

struct Scientist{
     int score;
    string name;
    Scientist(string _name, int _score){
        this->name = _name;
        this->score = _score;
    }
    Scientist(){}
    void print() {
        cout << name << endl;
    }
};

class  Kolejka{
public:

private:
    Scientist * arr;
     int first ,last ,size;
     int inc( int val) {
        return(val +1)% (size + 1);
    }
    void foreach(void(*fun)(Scientist)) {
         int it = first;
        while(it != last) {
            fun(arr[it]);
            it = inc(it);
        }
    }

public:
    Kolejka( int sizeArr){
        first = last = 0;
        size = sizeArr;
        arr = new Scientist[size + 1];
    }

    ~Kolejka (){
        delete  [] arr;
    }

    bool empty(){
        if(first == last)
            return true;
        return false;
    }

    Scientist front(){
        return arr[first];
    }

    Scientist pop (){
        Scientist scientist = front();
        first = inc(first);
        if (last==first) {
            throw "XD";
        }
        return scientist;
    }

    void push(Scientist value){
        arr[last] = value;
        last = inc(last);
        if (last==first) {
            throw "XD";
        }
    }


    void print() {
        // cout<< "STACK " <<endl;
        foreach( [](Scientist s) { s.print(); });
    }

     int maxDiff(int *changeMin, int *changeMax){
         int max = front().score;
         int min = max;
         int scoreTmp;
         int it = first;
        while(it != last) {
            scoreTmp =arr[it].score;
            if(scoreTmp > max) {
                max = scoreTmp;
            }
            if(scoreTmp < min) {
                min = scoreTmp;
            }
            it = inc(it);
        }
        *changeMin = min;
        *changeMax = max;
        return max-min;
    }
    

        int mean(){
         int sum = 0;
         int it = first;
        while(it != last) {
            sum +=arr[it].score;

            it = inc(it);
        }
        return sum;
    }
         void findMinMax(int *changeMin, int *changeMax){
         int max = front().score;
         int min = max;
         int scoreTmp;
         int it = first;
        while(it != last) {
            scoreTmp =arr[it].score;
            if(scoreTmp > max) {
                max = scoreTmp;
            }
            if(scoreTmp < min) {
                min = scoreTmp;
            }
            it = inc(it);
        }
        *changeMin = min;
        *changeMax = max;
    }

};



int appendSum(Kolejka &k, int size, int *arr){
    int score;
    string name;
    string surname;
    int sum = 0;
    for( int i = 0; i < size/2; i++ ){
        cin >> name >> surname >> score;
        k.push(Scientist(name + " " + surname, score));
        sum += score;
        arr[i] = score;
    }
    return sum;
}

void swap( Kolejka &scientists1,  Kolejka &scientists2) {
    Scientist s1 = scientists1.pop();
    Scientist s2 = scientists2.pop();
    scientists1.push(s2);
    scientists2.push(s1);
}


int abs(int x) {
    return x > 0 ? x : -x;
}

int main()
{
    ios_base::sync_with_stdio(false);
    
    int numberOfScientists;
    int maxDiffPoints;
    int bestIndex =0;
    bool didntBrake = true;
    int diff1, diff2;
    int sum1 = 0, sum2 = 0;
    int sumMeans = 2000000;
    int min1 = -1, max1 = 200000;
    int min2 = -1, max2 = 200000;
    cin >> numberOfScientists >> maxDiffPoints;
    Kolejka scientists1(numberOfScientists/2), scientists2(numberOfScientists/2);
    int arrScores1[numberOfScientists/2], arrScores2[numberOfScientists/2];

    sum1 = appendSum(scientists1,numberOfScientists, arrScores1 );
    sum2 = appendSum(scientists2,numberOfScientists, arrScores2 );
    bool meanHappened = true;
        diff1 = scientists1.maxDiff(&min1, &max1);    
        diff2 = scientists2.maxDiff(&min2, &max2); 
       
    for(int i = 0; i < numberOfScientists/2; i++) {
    

        if(diff1 <= maxDiffPoints && diff2 <= maxDiffPoints ) {
            
            if(abs(sum1 - sum2) < sumMeans ) {
                sumMeans = (sum1 - sum2);
                bestIndex = i;
            }
            if(sum1 == sum2){
                scientists1.print();
                cout<<endl;
                scientists2.print();
                didntBrake = false;
                break;
            }
        }
        // cout <<"Sum1: " << sum1<<endl;
        // cout << sum2<<endl;
       // swapSum(scientists1, scientists2, sum1, sum2);
        Scientist s1 = scientists1.pop();
        Scientist s2 = scientists2.pop();

        sum1 -= s1.score;
        sum1 += s2.score;
        
        sum2 -= s2.score;
        sum2 += s1.score;
        
        scientists1.push(s2);
        scientists2.push(s1);
        if(min1 == s1.score || max1 == s1.score) {
        scientists1.findMinMax(&min1, &max1);    
                diff1 =  max1 - min1;   
        }
        if(min2 == s2.score || max2 == s2.score) {
        scientists2.findMinMax(&min2, &max2);
                diff2 = max2 - min2;  
        }
        
        if(min1 > s2.score || max1 < s2.score) {
        scientists1.findMinMax(&min1, &max1);    
                diff1 =  max1 - min1;   
        }
        if(min2 > s1.score || max2 < s1.score) {
        scientists2.findMinMax(&min2, &max2);
                diff2 = max2 - min2;  
        }
    
    }


    if(didntBrake) {
        for( int i = 0; i < bestIndex +numberOfScientists/2; i++ ){
            swap(scientists1, scientists2);
        }
        
        scientists1.findMinMax(&min1, &max1);    
                diff1 =  max1 - min1;   
        scientists2.findMinMax(&min2, &max2);
                diff2 = max2 - min2;  
        
        if(diff1 <= maxDiffPoints && diff2 <= maxDiffPoints) {
        
            scientists1.print();
            cout << endl;
            scientists2.print();
            
            

        }
        else {
            cout << "NIE" << endl;
        }
    }

    return 0;
}
