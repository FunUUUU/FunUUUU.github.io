---
title: 「Luogu P2370」 yyy2015c01的U盘
date: 2018-09-26 14:42:37
tags: ["Luogu", "二分答案", "背包"]
mathjax: true
---

### 解题思路
---
既然是最小化最大值，那就二分答案啊。
每次用0/1背包判断能否满足题目中给出的条件。那岂不是很简单喽。

### 代码
---
```cpp
#include <algorithm>
#include <iostream>
#include <cstring>
#include <cstdio>
using namespace std;
const int maxn = 1003;
int n, p, S;
bool flag = false;
struct FIL {
	int v, w;
}fil[maxn];
int dp[maxn];
inline bool judge(int mid) {
	memset(dp, 0, sizeof(dp));
	for(int i=1; i<=n; i++) {
		for(int j=S; j>=0; j--) {
			if(j >= fil[i].w && fil[i].w <= mid)
				dp[j] = max(dp[j-fil[i].w] + fil[i].v, dp[j]);
		}
	}
	if(dp[S] >= p) return true;
	else return false;
}
int main() {
	scanf("%d%d%d", &n, &p, &S);
	for(int i=1; i<=n; i++)
		scanf("%d%d", &fil[i].w, &fil[i].v);
	int l = 0, r = 1000, ans = -1;
	while (l <= r) {
		int mid = (l + r) >> 1;
		if(judge(mid)) r = mid-1, ans = mid;
		else l = mid+1;
	}
	if(ans == -1) printf("No Solution!\n");
	else printf("%d", ans);
}
```
