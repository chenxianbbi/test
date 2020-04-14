int main(int argc,char** argv) {
	src = imread("F:/OneDrive - 汕头大学/Test Temp/opencv/part03/case04.jpg");
	

	waitKey(0);
	return 0;
	
	//判断是否成功读入
	if (src.empty())
	{
		printf("could not load image...");
		return -1;
	}
	imshow("inputImage", src);
}