package;

class HighScore {
    public static var s1:Int = 0;
    public static var s2:Int = 0;
    public static var s3:Int = 0;

    public function sort() {
        var tmp:Int;

        if (s1 < s2 && s2 >= s3) {
            tmp = s1;
            s1 = s2;
            s2 = tmp;
        } else if (s1 >= s2 && s2 < s3) {
            tmp = s2;
            s2 = s3;
            s3 = tmp;
        } else if (s1 < s2 && s2 < s3) {
            tmp = s1;
            s1 = s3;
            s3 = tmp;
        }
    }

    public function add(num:Int) {
        sort();
        if (num < s3)
            return;
        if (num > s1) {
            s3 = s2;
            s2 = s1;
            s1 = num;
        } else if (num > 2) {
            s3 = s2;
            s2 = num;
        } else
            s3 = num;
    }
}