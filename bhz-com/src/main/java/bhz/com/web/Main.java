package bhz.com.web;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/6/20.
 */
public class Main {

    public static void main(String arg[]){

        // 用Java8查询出arr[] 包含'i'的值 对查询出的值从小到大排序 并打印出来
        // 结果: bi hui shi ti xi
        String arr[] = {"shan","xi","er","shou","hui","bi","shi","ti","mu"};
        Arrays.stream(arr).filter(
                i -> i.contains("i")
        ).sorted(
                String::compareTo
        ).collect(Collectors.toList()).forEach(System.out::println);

        System.out.println();

    }
}
