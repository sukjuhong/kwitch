import { Loader2 } from "lucide-react";

export default function Loading() {
  return (
    <div className="flex flex-1 justify-center items-center">
      <Loader2 className="mr-2 h-4 w-4 animate-spin" />
      Please wait...
    </div>
  );
}
