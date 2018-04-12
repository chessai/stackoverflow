public class Queen{

    public static void main(String[] args) {
      long startTime = System.nanoTime();
      int N = 14; 
      getQueens(N);
      long endTime = System.nanoTime();

      long duration = (endTime - startTime) / 1000000;

      System.out.println("Needed: " + duration + " ms");
    }
    
    static int getQueens (int N) {
      int res = 0;
      for(int i = 0; i < N; i++) {
        int pos = 1 << i;
        res += run(N, pos << 1, pos >> 1, pos, N - 2);
      }
      return res;
    }

    static int run(int N, long diagR, long diagL, long mid, int depth) {
        long valid = mid | diagL | diagR;
        int resBuffer = 0;

        for (int i = 0; i < N; i++) {
            int pos = 1 << i;
            if ((valid & pos) > 0) {
                continue;
            }
            if (depth == 0) {
                resBuffer++;
                continue;
            }
            long n_mid = mid | pos;
            long n_diagL = (diagL >> 1) | (pos >> 1);
            long n_diagR = (diagR << 1) | (pos << 1);

            resBuffer += run(N, n_diagR, n_diagL, n_mid, depth - 1);
        }
        return resBuffer;
    }
}
