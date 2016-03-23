texture gTexture;

technique hello
{
    pass P0
    {
        Texture[0] = gTexture;
		ColorOp[0] = SelectArg1;
		ColorArg1[0] = Texture;
		AlphaOp[0] = SelectArg1;
		AlphaArg1[0] = Texture;
		ColorOp[1] = Disable;
		AlphaOp[1] = Disable;
    }
}
