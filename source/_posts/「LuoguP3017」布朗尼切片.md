---
title: 「Luogu P3017」 布朗尼切片
date: 2018-09-26 14:46:59
tags: ["Luogu", "二分答案", "前綴和"]
mathjax: true
---

### 解题思路
---
首先肯定是要二分答案的嘛，因为要最大化最小值啊。
那如何判断一个答案是否可行呢？
我们只需要先对一行进行判断，如果能将这一行分成大于等于 $mid$ (二分出来的答案) 的蛋糕 $B$ 块以上，就证明这一行可以单独劈成一条，如果不行的话，就和下一行一起放在一条中去判断，还不行的话就在加一行，观察一下，这样子分出来的条数是极限情况，也就是说，如果还不能分成大于等于 $A$ 条的话，那就不可能行了。反之，如果到最后大于等于 $A$ 条，那这个答案就是可行的。
中间的过程可以加入二维前缀和优化。

### 代码
---
```cpp
#include <iostream>
#include <cstring>
#include <cstdio>
using namespace std;
const int maxn = 503;
int sum[maxn][maxn], n, m, arr[maxn][maxn], a, b;
inline int read() {
	int x = 0, f = 1; char c = getchar();
	while (c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
	while (c <= '9' && c >= '0') {x = x*10 + c-'0'; c = getchar();}
	return x * f;
}
inline int check(int x1, int y1, int x2, int y2) {
	return sum[x2][y2] + sum[x1-1][y1-1] - sum[x1-1][y2] - sum[x2][y1-1];
}
inline bool judge(int mid) {
	int i = 1, tot = 0, now, r = 1, ff;
	while (i <= n) {
		now = 1, ff = 0;
		for(int j=1; j<=m; j++)
			if(check(r, now, i, j) >= mid)
				now = j+1, ff ++;
		if(ff >= b) r = i+1, tot++;
		i ++;
	}
	if(tot >= a) return true;
	else return false;
}
int main() {
	n = read(), m = read(), a = read(), b = read();
	for(int i=1; i<=n; i++) {
		int summ = 0;
		for(int j=1; j<=m; j++) {
			arr[i][j] = read();
			summ += arr[i][j];
			sum[i][j] += sum[i-1][j] + summ;
		}
	}
	int l = 0, r = sum[n][m], ans;
	while (l < r) {
		int mid = (l + r) >> 1;
		if(judge(mid)) l = mid+1, ans = mid;
		else r = mid;
	}
	printf("%d", ans);
}
```

