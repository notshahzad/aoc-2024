use core::panic;
use std::fs::read_to_string;
fn main() -> std::io::Result<()> {
    let mut args = std::env::args();
    let filename = args.next().expect("filename can't be null");
    let input_file = args.next().expect("please provide an input file");
    let part = args
        .next()
        .expect(format!("{filename} input_file_path part_1|part_2").as_str());

    let mut list_1: Vec<u32> = Vec::new();
    let mut list_2: Vec<u32> = Vec::new();

    for i in read_to_string(input_file)?.lines() {
        let (el_1, el_2) = i
            .split_once(" ")
            .expect("something wrong with input file unable to split on space");
        list_1.push(el_1.trim().parse().unwrap());
        list_2.push(el_2.trim().parse().unwrap());
    }
    list_1.sort();
    list_2.sort();

    // part 1
    if part == "part1" {
        let mut total_distance = 0;
        for (el_1, el_2) in std::iter::zip(list_1, list_2) {
            total_distance += (el_1).abs_diff(el_2);
        }
        println!("{total_distance}");
    }
    // part 2
    else if part == "part2" {
        let mut total_similarity_score = 0;
        let mut list_2_idx = 0;
        for el in list_1.iter() {
            let mut total_occurence = 0;
            if *el < list_2[list_2_idx] {
                continue;
            }
            while *el > list_2[list_2_idx] {
                list_2_idx += 1;
            }
            while list_2[list_2_idx] == *el {
                total_occurence += 1;
                list_2_idx += 1;
            }
            total_similarity_score += el * total_occurence;
        }
        println!("{total_similarity_score}");
    } else {
        panic!("bruh please provide a valid part number");
    }

    Ok(())
}
