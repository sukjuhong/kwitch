import { Channel, User } from "@kwitch/types";
import { Request, Response } from "express";
import {
  Authorized,
  Controller,
  CurrentUser,
  Get,
  Req,
  Res,
} from "routing-controllers";
import { Service } from "typedi";

@Service()
@Controller("/users")
export class UserController {
  @Get("/me")
  @Authorized()
  public me(
    @Req() req: Request,
    @Res() res: Response,
    @CurrentUser() user: User & { channel: Channel },
  ) {
    return res.json({
      success: true,
      content: {
        user,
      },
    });
  }
}
