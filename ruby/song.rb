
map = Array.new(60, 0)
count=0;

nimeshika_array = [40,20,60]


for value in nimeshika_array do
  rem = value % 60
  comp = 60-rem

  if (map[comp % 60] > 0)
    count += map[comp % 60]
  end

  map[rem] += 1;
end

count

# int[] map = new int[60];
# int count=0;

# for(int n : time){
#     int rem = n % 60;
#     int comp = (60-rem);
#     if(map[comp % 60] > 0); //comp%60 is to ensure you do not exceed map size
#         count += map[comp % 60];  //eg if n=0, comp==60 and so map[60] will throw an out of bounds error.
#     map[rem]++;   
# }
# return count;





# class Solution {
#   public int numPairsDivisibleBy60(int[] time) {
#         int[] map = new int[60];
#         int count=0;
        
#         for(int n : time){
#             int rem = n % 60;
#             int comp = (60-rem);
#             if(map[comp % 60] > 0); //comp%60 is to ensure you do not exceed map size
#                 count += map[comp % 60];  //eg if n=0, comp==60 and so map[60] will throw an out of bounds error.
#             map[rem]++;   
#         }
#         return count;
#     }
#  }